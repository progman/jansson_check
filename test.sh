#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
APP='./bin/jansson_check';
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
function test1()
{
# create temp dir and files
	local TEST_TMPDIR="/tmp";
	if [ "${TMPDIR}" != "" ] && [ -d "${TMPDIR}" ];
	then
		TEST_TMPDIR="${TMPDIR}";
	fi


	local TMP1;
	TMP1="$(mktemp --tmpdir="${TEST_TMPDIR}" 2> /dev/null)";
	if [ "${?}" != "0" ];
	then
		echo "can't make tmp file";
		return 1;
	fi


	echo -e "{\na : []\n}\n" > "${TMP1}";


	"${APP}" "${TMP1}" &> /dev/null;
	if [ "${?}" == "0" ];
	then
		echo "ERROR[test1]: strange behavior";
		rm -rf -- "${TMP1}";
		return 1;
	fi


	echo -e "{\n\"a\" : []\n}\n" > "${TMP1}";


	"${APP}" "${TMP1}" &> /dev/null;
	if [ "${?}" != "0" ];
	then
		echo "ERROR[test2]: strange behavior";
		rm -rf -- "${TMP1}";
		return 1;
	fi


	rm -rf -- "${TMP1}";


	return 0;
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# general function
function main()
{
	if [ ! -e "${APP}" ];
	then
		echo "ERROR: make it";
		return 1;
	fi


	test1;
	if [ "${?}" != "0" ];
	then
		return 1;
	fi


	echo "ok, test passed";
	return 0;
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
main "${@}";

exit "${?}";
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#