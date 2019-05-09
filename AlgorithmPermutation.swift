import UIKit

func permutationPrint(_ param:String) -> [String] {
    
    if param.count == 1 {
        return [param]
    }
    
    var combinedArray = [String]()
    
    for (index, char) in param.enumerated() {
        var input = param
        _ = input.remove(at: input.index(input.startIndex, offsetBy: index))
        let tempCombined = combine(char, permutationPrint(input))
        combinedArray.append(contentsOf: tempCombined)
    }
    
    return combinedArray
}

func combine(_ char:Character, _ arrayInput:[String]) -> [String] {
    var outputArray = [String]()
    for string in arrayInput {
        outputArray.append(string + String(char))
    }
    return outputArray
}

let res = permutationPrint("abb")

let set = Set(res)

for str in set {
    print(str)
}


