import glob
import os

def combine_files(directory, out_file):
    with open(out_file, "w") as f:
        for file_path in glob.glob(f"{directory}/**/*.swift", recursive=True):
            with open(file_path, "r") as infile:
                content = infile.read()
                content = content.replace("return lv_event_code_t(rawValue: UInt32(self.rawValue))", "return lv_event_code_t(rawValue: UInt16(self.rawValue))") # Stupid patch for Pico
                f.write(content.replace("import CLVGL", ""))
                f.write("\n\n")
                
if __name__ == "__main__":
    directory = "Sources/SwiftLVGL"
    out_file = "SwiftyLVGL.swift"
    combine_files(directory, out_file)
