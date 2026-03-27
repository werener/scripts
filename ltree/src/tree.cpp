#include "tree.hpp"
#include <filesystem>

const int MAX_DEPTH = 3;
const bool WITH_HIDDEN = false;

bool is_hidden(std::string filename) {
    return !filename.empty() && 
           filename[0] == '.';
}

void print_file(std::string filename, int depth, bool print_hidden) {
    if (!print_hidden && is_hidden(filename))
        return;

    std::cout 
    << RED 
    << std::string(2 * (depth + 1), ' ') 
    << filename 
    << '\n' << RESET;   
}

void print_directory(std::string filename, int depth, bool print_hidden) {
    if (!print_hidden && is_hidden(filename))
        return;

    std::cout 
    << GREEN 
    << std::string(2 * (depth + 1), ' ') 
    << filename
    << "\\\n" << RESET;   
}

void traverse(std::string starting_path, int depth) {
    fs::path current_file = fs::canonical(starting_path);
    std::string filename = current_file.filename().string();

    if (!fs::exists(current_file)) {
        return;
    }

    if (!WITH_HIDDEN && is_hidden(filename)) {
        return;
    }

    if (!fs::is_directory(current_file)) {
        print_file(filename, depth, WITH_HIDDEN);
        return;
    }
    print_directory(filename, depth, WITH_HIDDEN);

    if (depth < 0 || depth > MAX_DEPTH) {
        return;
    }

   
    for (const auto &entry : fs::directory_iterator(current_file))
        traverse(entry.path(), depth + 1);
}