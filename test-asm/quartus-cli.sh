#!/bin/bash
# Set the Quartus installation directory
QUARTUS_DIR="$HOME/intelFPGA_lite/20.1/quartus"
# Set the project directory
PROJECT_DIR=$(realpath ..)
# Set the project name
PROJECT_NAME="processor_arm"
# Check for command-line arguments
RTL_SYNTHESIS_ONLY=false
USE_GUI=true
SHOW_HELP=false
for arg in "$@"; do
    case $arg in
    --rtl)
        RTL_SYNTHESIS_ONLY=true
        shift # Remove the argument from the list
        ;;
    --no-gui)
        USE_GUI=false
        shift # Remove the argument from the list
        ;;
    --help)
        SHOW_HELP=true
        shift # Remove the argument from the list
        ;;
    esac
done

if [ "$SHOW_HELP" = true ]; then
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  --rtl        Run RTL Simulation only. Skip Analysis and Synthesis"
    echo "  --no-gui     Run without GUI"
    echo "  --help       Show this help message"
    echo ""
    echo "This script runs Analysis and Synthesis, and RTL Simulation"
    echo "for the specified Quartus project."
    echo "RTL simulation can run with or without GUI."
    echo "To modify project name you need to modify PROJECT_NAME in this script"
    echo "The default is project name is 'processor_arm'"
    exit 0
fi

# Change to the project directory
cd "$PROJECT_DIR" || {
    echo "Project directory not found"
    exit 1
}

if [ "$RTL_SYNTHESIS_ONLY" = true ]; then
    echo "Running RTL Synthesis only for project: $PROJECT_NAME"
else
    # Run Analysis and Synthesis
    echo "Running Analysis and Synthesis for project: $PROJECT_NAME"
    $QUARTUS_DIR/bin/quartus_map --read_settings_files=on --write_settings_files=off $PROJECT_NAME -c $PROJECT_NAME

    if [ $? -ne 0 ]; then
        echo "Error during Analysis and Synthesis"
        exit 1
    fi
fi
# Run RTL Simulation
echo "Running RTL Simulation for project: $PROJECT_NAME"
if [ "$USE_GUI" = true ]; then
    GUI_FLAG=""
else
    GUI_FLAG="--no_gui"
fi
$QUARTUS_DIR/bin/quartus_sh -t "$HOME/intelFPGA_lite/20.1/quartus/common/tcl/internal/nativelink/qnativesim.tcl" $GUI_FLAG --rtl_sim "$PROJECT_NAME" "$PROJECT_NAME"

if [ $? -ne 0 ]; then
    echo "Error during RTL Simulation"
    exit 1
fi
echo "Analysis, Synthesis, Fitting, Timing Analysis, and RTL Simulation completed successfully."
