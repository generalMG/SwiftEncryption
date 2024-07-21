import Foundation

func runTool() {
    if #available(macOS 10.15, *) {
        let tool = MLEncoderTool()
        do {
            try tool.run()
        } catch {
            print("Error: \(error)")
        }
    } else {
        print("This tool requires macOS 10.15 or later.")
    }
}

runTool()
