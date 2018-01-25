function peco-ec2ssh() {
    local aws_profile_name=$1
    local aws_region=$2
    local ssh_user=$3
    local ssh_proxy=$4
    local proxy_user=$5
    echo "Fetching ec2 host..."
    local selected_host=$(myaws ec2 ls --profile=${aws_profile_name} --region=${aws_region} --fields='InstanceId PublicIpAddress LaunchTime Tag:Name Tag:attached_asg' | sort -k4 | peco | cut -f2)
    if [ -n "${selected_host}" ]; then
        if [ -z "${ssh_proxy}" ]; then
            BUFFER="ssh ${ssh_user}@${selected_host} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
        else
            BUFFER="ssh -t ${proxy_user}@${ssh_proxy} ssh ${ssh_user}@${selected_host} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
        fi
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ec2ssh

function peco-ec2ssh-with-proxy() {
    local aws_profile_name=$1
    local aws_region=$2
    local ssh_user=$3
    local ssh_proxy_profile=$4
    local proxy_user=$5
    echo "Fetching ec2 host..."
    local selected_proxy=$(myaws ec2 ls --profile=${ssh_proxy_profile} --region=${aws_region} --fields='InstanceId PublicIpAddress LaunchTime Tag:Name Tag:attached_asg' | sort -k4 | peco | cut -f2)
    if [ -n "${selected_proxy}" ]; then
        peco-ec2ssh $aws_profile_name $aws_region $ssh_user $selected_proxy $proxy_user
    fi
    zle clear-screen
}
zle -N peco-ec2ssh-with-proxy

function peco-z-search() {
    which peco z > /dev/null
    if [ $? -ne 0 ]; then
        echo "Please install peco and z"
        return 1
    fi
    local res=$(z | sort -rn | cut -c 12- | peco)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}
zle -N peco-z-search

