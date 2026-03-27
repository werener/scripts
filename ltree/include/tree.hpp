#pragma once

#include <iostream>
#include <filesystem>

#define RED     "\033[31m"
#define GREEN   "\033[32m"
#define RESET   "\033[0m"

namespace fs = std::filesystem;

// char *a = "├└│─";
bool is_hidden(std::string filename);
void print_file(std::string filename, int depth, bool print_hidden);
void print_directory(std::string filename, int depth, bool print_hidden);
void traverse(std::string starting_path, int depth = 0); 