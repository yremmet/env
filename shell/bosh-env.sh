export BOSH_ENV_FOLDER="~/DEV/bosh/"

function bosh-env(){
    export BOSH_ENVIRONMENT=vbox
    export BOSH_CLIENT=admin
    export BOSH_CLIENT_SECRET=`bosh int $BOSH_ENV_FOLDER/$1/creds.yml --path /admin_password`
}
