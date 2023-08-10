#!/bin/bash
echo "Menu:"
echo "1. Create Employee Record"
echo "2. Delete Employee Record"
echo "3. Search Employee Record"
echo "4. Display Employee Record"
echo "5. Sort Record"
echo "6. List of Records"
echo "7. exit"

is_integer(){
        if [[$1 =~ ^[0-9]+$ ]]; then
                return 0
        else
                return 1

        fi
}

is_integers() {
  if [[ $1 =~ ^[0-9]+$ ]]; then
    return 0
  else
    return 1
  fi
}

read -rp "Please seclect one menu option: " input

while ! is_integers "$input"; do
  read -rp "Invalid input. Please enter an integer: " input
done


echo "You entered: $input"

create_employee_record(){
	echo "Enter Employee number"
	read emp_no
	echo "Enter Name of Employee"
	read name
	echo "Enter Mobile Number"
	read mobile_no

	if grep -q "^.*$emp_number,.*$" employee.txt; then
		echo "Employee Number $emp_number already exists. Cannot create duplicate records."
	else
		echo "$emp_no,$name,$mobile_no" >> employee.txt
		while true; do
			echo "Do you want to add another employee?(yes/no): "
		        read -r choice
			if [[ $choice == "no" ]]; then
				break
			else
				create_employee_record
			fi

			# Consume the extra input in the buffer
			while read -r -t 0; do
				read -r
			done
		done
	fi

}

delete_employee(){
	echo "Enter the Employee Number of employee you want to delete"
        read employee_no
	local file_path="employee.txt"

	if grep -q "$employee_no" "$file_path"; then
		sed -i "/^.*$employee_no,.*\$/d" "$file_path"

		echo "Employee with name $employee_no deleted sucessfully."

	else
		echo "Employee with name $employee_no not found."

	fi
	while true; do
                        echo "Do you want to delet another employee?(yes/no): "
                        read -r choice
                        if [[ $choice == "no" ]]; then
                                break
                        else
                                delete_employee
                        fi

		done


}

search_employee(){

	read -p "Enter the Employee Number to search: " emp_no
	grep  -i "^.*$emp_no,.*$" employee.txt

	echo "Enter Name to search the employee"
}

display_all_employee_records() {
    local file_path="employee.txt"
    cat "$file_path"
}


sort_recoreds(){
	echo "Employee record sorted"
}

case "$input" in
	1)
		create_employee_record
		;;
	2)
		delete_employee
		;;
	3)
		search_employee
		;;
	4)
		display_all_employee_records
		;;
	5)
		Sort_records
		;;
	*)
		echo "Not selected"
		;;
esac





