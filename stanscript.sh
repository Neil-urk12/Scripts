#!/bin/bash

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "Ollama is not installed. Installing now..."
    
    # Install Ollama on Fedora
    curl -fsSL https://ollama.com/install.sh | sh
    
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