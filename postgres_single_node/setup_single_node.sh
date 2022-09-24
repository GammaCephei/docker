username='POSTGRES_USER=postgres'
password='POSTGRES_PASSWORD=changeme'
version='POSTGRES_VERSION=10.20'
port='POSTGRES_PORT=5555'
fill_flag=''

print_usage(){
    printf "\nUsage: ./setup_single_node.sh [OPTIONS] e.g. ./setup_single_node.sh -u 1337_wookie_hunter -p secure_passwd123 \n 
    \t -u : Supply a username. Default: postgres \n 
    \t -p : Supply a password. Default: changeme \n
    \t -v : Supply a postgres version. Supported versions 10,11,12,13,14. Default 10.20\n.
    \t -l : Supply mapping for the external port i.e. [external]:5432 default internal postgres container port. Defaults to 5555\n
    \t -f : Populates the table with data for testing. \n
    \t -h : print this help and exit the script \n"
}
while getopts 'u:p:v:l:fh' flag; do
  case "${flag}" in
    u) username="POSTGRES_USER=${OPTARG}"; printf "Setting up with username: %s\n" ${username} ;;
    p) password="POSTGRES_PASSWORD=${OPTARG}"; printf "Setting up with supplied password.\n" ;;
    v) version="POSTGRES_VERSION=${OPTARG}"; printf "Setting up with supplied version: %s\n" ${version}  ;;
    l) port="POSTGRES_PORT=${OPTARG}"; printf "Setting up with local port: %s\n" ${port} ;;
    f) fill_flag='true' ;;
    h) print_usage; exit 1 ;;
    *) ;;
  esac
done

printf "%s\n%s\n%s\n%s" "${username}" "${password}" "${version}" "${port}"> ".env"

docker-compose -f docker-compose-postgres-single.yaml up -d