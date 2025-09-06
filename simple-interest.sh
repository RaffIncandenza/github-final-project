#!/bin/bash

# This script calculates simple interest given principal,
# annual rate of interest, and time period in years.

# Author: Upkar Lidder (IBM)
# Additional Authors:
# RaffIncandenza
# Refactored by `RaffIncandenza` for robustness and security

set -euo pipefail  # Exit on error, undefined variable, or pipe failure

# Function to display usage information
usage() {
    echo "Usage: $0"
    echo "This script will prompt you for the principal, interest rate, and time."
    echo "All values must be positive numbers."
    exit 1
}

# Function to validate a positive numeric input
validate_input() {
    local input="$1"
    local name="$2"

    # Check if input is empty
    if [[ -z "$input" ]]; then
        echo "Error: $name cannot be empty." >&2
        return 1
    fi

    # Check if input is a positive number (integer or decimal)
    if [[ ! "$input" =~ ^[0-9]+(\.[0-9]+)?$ ]] || (( $(echo "$input <= 0" | bc -l) )); then
        echo "Error: $name must be a positive number." >&2
        return 1
    fi

    return 0
}

# Main execution flow
main() {
    echo "Simple Interest Calculator"
    echo "--------------------------"

    # Read and validate principal
    read -rp "Enter the principal amount: " principal
    validate_input "$principal" "Principal" || exit 1

    # Read and validate annual interest rate
    read -rp "Enter the annual rate of interest (%): " rate
    validate_input "$rate" "Annual rate" || exit 1

    # Read and validate time period
    read -rp "Enter the time period (in years): " time
    validate_input "$time" "Time period" || exit 1

    # Perform calculation using bc for floating point precision
    interest=$(echo "scale=2; $principal * $rate * $time / 100" | bc)

    # Display the result
    echo "--------------------------"
    printf "The simple interest is: %.2f\n" "$interest"
}

# Check if the script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # If not sourced, run the main function
    main
fi
