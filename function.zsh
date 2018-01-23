function peco-ec2ssh() {
   aws_profile_name=$1
   aws_region=$2
   ssh_user=$3
  echo "Fetching ec2 host..."
  local selected_host=$(myaws ec2 ls --profile=${aws_profile_name} --region=${aws_region} --fields='InstanceId PublicIpAddress LaunchTime Tag:Name Tag:attached_asg' | sort -k4 | peco | cut -f2)
  if [ -n "${selected_host}" ]; then
    BUFFER="ssh ${ssh_user}@${selected_host} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ec2ssh
