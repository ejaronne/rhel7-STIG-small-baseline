control 'SV-204457' do
  title 'The Red Hat Enterprise Linux operating system must define default permissions for all authenticated users
    in such a way that the user can only read and modify their own files.'
  desc 'Setting the most restrictive default permissions ensures that when new accounts are created, they do not
    have unnecessary access.'
  tag 'rationale': ''
  tag 'check': 'Verify the operating system defines default permissions for all authenticated users in such a way
    that the user can only read and modify their own files.
    Check for the value of the "UMASK" parameter in "/etc/login.defs" file with the following command:
    Note: If the value of the "UMASK" parameter is set to "000" in "/etc/login.defs" file, the Severity is raised to a
    CAT I.
    # grep -i umask /etc/login.defs
    UMASK  077
    If the value for the "UMASK" parameter is not "077", or the "UMASK" parameter is missing or is commented out, this
    is a finding.'
  tag 'fix': 'Configure the operating system to define default permissions for all authenticated users in such a way
    that the user can only read and modify their own files.
    Add or edit the line for the "UMASK" parameter in "/etc/login.defs" file to "077":
    UMASK  077'
  tag 'legacy': ['SV-86619', 'V-71995']
  tag 'false_negatives': ''
  tag 'false_positives': ''
  tag 'documentable': false
  tag 'mitigations': ''
  tag 'potential_impacts': ''
  tag 'third_party_tools': ''
  tag 'mitigation_controls': ''
  tag 'responsibility': ''
  tag 'ia_controls': ''
  tag 'severity_override_guidance': ''
  tag 'severity': 'medium'
  tag 'gtitle': 'SRG-OS-000480-GPOS-00228'
  tag 'gid': 'V-204457'
  tag 'rid': 'SV-204457r603261_rule'
  tag 'stig_id': 'RHEL-07-020240'
  tag 'fix_id': 'F-4581r88564_fix'
  tag 'cci': ['CCI-000366']
  tag nist: ['CM-6 b']

  if login_defs.read_params['UMASK'].eql?('000')
    impact 0.5
  else
    impact 0.5
  end
  describe login_defs do
    its('UMASK') { should eq '077' }
  end
end
