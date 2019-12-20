export BOSH_ENV_FOLDER="${DEV_PATH}/bosh/"

function bosh-env(){
    export BOSH_ENVIRONMENT=vbox
    export BOSH_CLIENT=admin
    export BOSH_CLIENT_SECRET=`bosh int $BOSH_ENV_FOLDER/$1/creds.yml --path /admin_password`
}


function bd(){
	echo $1
	if [[ "$1" != "" ]]; then
		name=$(bosh int manifests/postgres-dev-local.yml --path /name | sed -e 1b)
		echo "bosh deploy -d $name $1"
		bosh deploy -d $name $1
	else
		bosh deployments
	fi

}

function bdd(){ #bosh delete deployment
	bosh delete-deployment -n -d $1 --force
}

function bcd(){ #bosh clear deployments
	bd | awk '{print $1}' | while read line ; do echo "bdd $line" ; done
}


function cleanBosh(){ 
	bosh releases | grep -v "*" | awk '{print($3)}' |while read line ; do echo "bosh delete-release $line -n" ; done
}




