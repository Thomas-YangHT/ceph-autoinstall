export S3_ACCESS_KEY="V4J9G5OGVYCJWIRIGSL1"
export S3_SECRET_KEY="zt6nLe7j4lukAXXm5rSqgAIZxZN6I6Ie6cC3SOaP"
export S3_HOST="192.168.31.15"
export S3_PORT="8080"
#a=(`docker exec mon radosgw-admin user info --uid=123|grep -Po "access_key\":\K.*|secret_key\":\K.*"|sed -e 's/"//g' -e 's/,//'|xargs`)
