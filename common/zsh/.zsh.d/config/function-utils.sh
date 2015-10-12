function normalize-json () {
    local str="$1"

    node -e 'var str = process.argv[1]; var obj = (new Function("return " + str))(); console.log(JSON.stringify(obj));' $str
}

function curl-jsonrpc-request () {
    local url="$1"
    local method="\"$2\""
    local params="$3"
    local raw_json="{ jsonrpc: '2.0', 'id': 1, 'method': $method, 'params': $params }"
    local json="$(normalize-json $raw_json)"

    curl -s $url \
         -H "Accept: application/json" -H 'Content-Type: application/json' \
         -d $json \
         ${@:4}
}
