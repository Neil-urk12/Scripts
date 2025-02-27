#!/bin/bash

# Detect package manager
if command -v apt &> /dev/null; then
    PKG_MANAGER="apt"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
else
    echo "Unsupported package manager. This script supports Debian/Ubuntu (apt) and Fedora (dnf) based systems."
    exit 1
fi

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "Ollama is not installed. Installing now..."
    
    # Install Ollama based on distribution
    if [ "$PKG_MANAGER" = "apt" ]; then
        # Install dependencies for Debian/Ubuntu
        sudo apt update -y && sudo apt upgrade -y
        curl -fsSL https://ollama.com/install.sh | sh
    else
        # Install Ollama on Fedora
        curl -fsSL https://ollama.com/install.sh | sh
    fi
    
    # Check if installation was successful
    if command -v ollama &> /dev/null; then
        echo "Ollama has been successfully installed!"
    else
        echo "Failed to install Ollama. Please try installing manually."
        exit 1
    fi
else
    echo "Ollama is already installed"
fi

# Ask user if they want to install models
echo -e "\nWould you like to install some AI models? (y/n)"
read -r install_models

if [[ $install_models =~ ^[Yy]$ ]]; then
    echo -e "\nAvailable models:"
    echo "1. Mistral 7B"
    echo "2. Deepseek R1 8B"
    echo "3. Llama 3.1 8B" 
    echo "4. Qwen 2.5-coder 7B"
    echo "5. Mistral-Nemo"
    echo "6. Granite3.1 Dense"
    echo -e "\nEnter the numbers of the models you want to install (e.g., 1 2 3 4):"
    read -r model_choices
    
    for choice in $model_choices; do
        case $choice in
            1)
                echo "Installing Mistral 7B..."
                ollama pull mistral
                ;;
            2)
                echo "Installing Deepseek R1 8B..."
                ollama run deepseek-r1
                ;;
            3)
                echo "Installing Llama 3.1 8B..."
                ollama run llama3.1
                ;;
            4)
                echo "Installing Qwen 2.5-coder 7B..."
                ollama run qwen2.5-coder
                ;;
            5)
                echo "Installing Mistral-Nemo"
                ollama run mistral-nemo
                ;;
            6)
                echo "Installing Granite3.1 Dense"
                ollama run granite3.1-dense
                ;;
        esac
    done
    echo "Model installation complete!"
fi
