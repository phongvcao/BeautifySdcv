function bsdcv() {
for arg in "$@"; do
    $( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../python && pwd)/stardict.py "${arg}"
done
}

function vsdcv() {
PYSCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../python && pwd)
PYTHON_COMMAND="import sys; sys.path.insert(0, '"${PYSCRIPT_DIR}"')"
VIM_COMMAND="setlocal buftype=nofile bufhidden=hide noswapfile readonly filetype=stardict"

FINAL_DEFINITIONS=""
ARGS_LIST=""

for arg in "$@"; do
    FINAL_DEFINITIONS+="$(python -c "${PYTHON_COMMAND}; import stardict; print(stardict.getDefinition([['$arg']]))")""\n""\n"
done

echo -e "${FINAL_DEFINITIONS}"
echo -e "${FINAL_DEFINITIONS}" | vim -c "${VIM_COMMAND}" -
}
