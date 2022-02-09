control 'SV-204551' do
  title 'The Red Hat Enterprise Linux operating system must audit all uses of the chsh command.'
  desc 'Reconstruction of harmful events or forensic analysis is not possible if audit records do not contain enough
    information.
    At a minimum, the organization must audit the full-text recording of privileged access commands. The organization
    must maintain audit trails in sufficient detail to reconstruct events to determine the cause and impact of
    compromise.
    When a user logs on, the auid is set to the uid of the account that is being authenticated. Daemons are not user
    sessions and have the loginuid set to -1. The auid representation is an unsigned 32-bit integer, which equals
    4294967295. The audit system interprets -1, 4294967295, and "unset" in the same way.'
  tag rationale: ''
  tag check: 'Verify the operating system generates audit records when successful/unsuccessful attempts to use the
    "chsh" command occur.
    Check that the following system call is being audited by performing the following command to check the file system
    rules in "/etc/audit/audit.rules":
    # grep -i /usr/bin/chsh /etc/audit/audit.rules
    -a always,exit -F path=/usr/bin/chsh -F auid>=1000 -F auid!=unset -k privileged-priv_change
    If the command does not return any output, this is a finding.'
  tag fix: 'Configure the operating system to generate audit records when successful/unsuccessful attempts to use
    the "chsh" command occur.
    Add or update the following rule in "/etc/audit/rules.d/audit.rules":
    -a always,exit -F path=/usr/bin/chsh -F auid>=1000 -F auid!=unset -k privileged-priv_change
    The audit daemon must be restarted for the changes to take effect.'
  tag legacy: %w{SV-86791 V-72167}
  tag false_negatives: ''
  tag false_positives: ''
  tag documentable: false
  tag mitigations: ''
  tag potential_impacts: ''
  tag third_party_tools: ''
  tag mitigation_controls: ''
  tag responsibility: ''
  tag ia_controls: ''
  tag severity_override_guidance: ''
  tag severity: 'medium'
  tag gtitle: 'SRG-OS-000037-GPOS-00015'
  tag satisfies: %w{SRG-OS-000037-GPOS-00015 SRG-OS-000042-GPOS-00020 SRG-OS-000392-GPOS-00172
                    SRG-OS-000462-GPOS-00206 SRG-OS-000471-GPOS-00215}
  tag gid: 'V-204551'
  tag rid: 'SV-204551r603261_rule'
  tag stig_id: 'RHEL-07-030720'
  tag fix_id: 'F-4675r462649_fix'
  tag cci: %w{CCI-000130 CCI-000135 CCI-000172 CCI-002884}
  tag nist: ['AU-3', 'AU-3 (1)', 'AU-12 c', 'MA-4 (1) (a)']

  audit_file = '/usr/bin/chsh'

  if file(audit_file).exist?
    impact 0.5
  else
    impact 0.0
  end

  if file(audit_file).exist?
    describe auditd.file(audit_file) do
      its('permissions') { should include ['x'] }
      its('action') { should_not include 'never' }
    end
  end

  unless file(audit_file).exist?
    describe "The #{audit_file} file does not exist" do
      skip "The #{audit_file} file does not exist, this requirement is Not Applicable."
    end
  end
end
