import Foundation

typealias Matrix = [[Int]]

var rotCount = 0
var mRotCount = 0
var swapHCount = 0
var swapVCount = 0
var operationLog: [String] = []

func generateRandomMatrix(_ rows: Int, _ columns: Int, minValue: Int = 0, maxValue: Int = 99) -> [[Int]] {
    var matrix = [[Int]]()
    for _ in 0..<rows {
        var row = [Int]()
        for _ in 0..<columns {
            let randomNumber = Int.random(in: minValue...maxValue)
            row.append(randomNumber)
        }
        matrix.append(row)
    }
    return matrix
}

func Rot(_ matrix: inout Matrix, aroundA row: Int, _ col: Int) {
    guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
    
    let a = matrix[row][col]
    let b = matrix[row][col+1]
    let c = matrix[row+1][col+1]
    let d = matrix[row+1][col]
    
    matrix[row][col] = d
    matrix[row][col+1] = a
    matrix[row+1][col+1] = b
    matrix[row+1][col] = c
    
    rotCount += 1
    operationLog.append("Rot(\(row), \(col))")
}

func flattenAndSort(_ matrix: Matrix) -> [Int] {
    let flattenedArray = matrix.flatMap { $0 }
    let sortedArray = flattenedArray.sorted()
    return sortedArray
}

func mRot(_ matrix: inout Matrix, aroundA row: Int, _ col: Int) {
    guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
    
    let a = matrix[row][col]
    let b = matrix[row][col+1]
    let c = matrix[row+1][col+1]
    let d = matrix[row+1][col]
    
    matrix[row][col] = b
    matrix[row][col+1] = c
    matrix[row+1][col+1] = d
    matrix[row+1][col] = a
    
    mRotCount += 1
    operationLog.append("mRot(\(row), \(col))")
}

func swapH(_ matrix: inout Matrix, aroundA row: Int, _ col: Int) {
    guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
    
    let a = matrix[row][col]
    let b = matrix[row][col+1]
    let c = matrix[row+1][col+1]
    let d = matrix[row+1][col]
    
    matrix[row][col] = d
    matrix[row][col+1] = c
    matrix[row+1][col] = a
    matrix[row+1][col+1] = b
    
    swapHCount += 1
    operationLog.append("swapH(\(row), \(col))")
}

func swapV(_ matrix: inout Matrix, aroundA row: Int, _ col: Int) {
    guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
    
    let a = matrix[row][col]
    let b = matrix[row][col+1]
    let c = matrix[row+1][col+1]
    let d = matrix[row+1][col]
    
    matrix[row][col] = b
    matrix[row][col+1] = a
    matrix[row+1][col+1] = d
    matrix[row+1][col] = c
    
    swapVCount += 1
    operationLog.append("swapV(\(row), \(col))")
}

func diagL(_ matrix: inout Matrix, aroundA row: Int, _ col: Int) {
    guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
    mRot(&matrix, aroundA: row, col)
    swapH(&matrix, aroundA: row, col)
}

func diagB(_ matrix: inout Matrix, aroundA row: Int, _ col: Int) {
    guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
    mRot(&matrix, aroundA: row, col)
    swapV(&matrix, aroundA: row, col)
}

// Функция для красивого вывода матрицы
func printMatrix(_ matrix: Matrix) {
    for row in matrix {
        print(row.map { String(format: "%2d", $0) }.joined(separator: " "))
    }
    print()
}

class Frame {
    func swap_00_01(_ matrix: inout Matrix) {
        let row = 0
        let col = 1
        guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
        Rot(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: 0, 0)
        mRot(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: row, col)
    }
    
    func swap_01_02(_ matrix: inout Matrix) {
        let row = 0
        let col = 0
        guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
        mRot(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: 0, 1)
        Rot(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: row, col)
    }
    
    func swap_00_10(_ matrix: inout Matrix) {
        let row = 1
        let col = 0
        guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
        mRot(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: 0, 0)
        Rot(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: row, col)
    }
    
    func swap_10_20(_ matrix: inout Matrix) {
        let row = 0
        let col = 0
        guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
        Rot(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: 1, 0)
        mRot(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: row, col)
    }
    
    func swap_02_12(_ matrix: inout Matrix) {
        let row = 1
        let col = 1
        guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
        Rot(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: 0, 1)
        mRot(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: row, col)
    }
    
    func swap_12_22(_ matrix: inout Matrix) {
        let row = 0
        let col = 1
        guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
        mRot(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: 1, 1)
        Rot(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: row, col)
    }
    
    func swap_20_21(_ matrix: inout Matrix) {
        let row = 1
        let col = 1
        guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
        mRot(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: 1, 0)
        Rot(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: row, col)
    }
    
    func swap_21_22(_ matrix: inout Matrix) {
        let row = 1
        let col = 0
        guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
        Rot(&matrix, aroundA: row, col)
        diagL(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: 1, 1)
        mRot(&matrix, aroundA: row, col)
        diagB(&matrix, aroundA: row, col)
    }
}

func casilkaLOWEST(_ matrix: inout Matrix, _ i: Int, _ j: Int) {
    let temp = Frame()
    switch (i, j) {
    case (0, 0):
        temp.swap_00_10(&matrix)
        temp.swap_10_20(&matrix)
    case (0, 1):
        temp.swap_00_01(&matrix)
        temp.swap_00_10(&matrix)
        temp.swap_10_20(&matrix)
    case (0, 2):
        temp.swap_01_02(&matrix)
        temp.swap_00_01(&matrix)
        temp.swap_00_10(&matrix)
        temp.swap_10_20(&matrix)
    case (1, 2):
        temp.swap_02_12(&matrix)
        temp.swap_01_02(&matrix)
        temp.swap_00_01(&matrix)
        temp.swap_00_10(&matrix)
        temp.swap_10_20(&matrix)
    case (2, 2):
        temp.swap_21_22(&matrix)
        temp.swap_20_21(&matrix)
    case (2, 1):
        temp.swap_20_21(&matrix)
    default:
        return
    }
}

func casilkaJOIN(_ matrix: inout Matrix, _ i: Int, _ j: Int, _ str: [Int], _ flag: Int) {
    let temp = Frame()
    if flag == 1 {
        switch (i, j) {
        case (0, 0):
            if(matrix[1][0] == str[1] || matrix[1][0] == str[2]) {
                temp.swap_00_01(&matrix)
                temp.swap_01_02(&matrix)
                temp.swap_02_12(&matrix)
                temp.swap_12_22(&matrix)
                temp.swap_21_22(&matrix)
            }
            else { temp.swap_00_10(&matrix) }
        case (0, 1):
            if(matrix[1][0] == str[1] || matrix[1][0] == str[2] ||
               matrix[0][0] == str[1] || matrix[0][0] == str[2] ) {
                temp.swap_01_02(&matrix)
                temp.swap_02_12(&matrix)
                temp.swap_12_22(&matrix)
                temp.swap_21_22(&matrix)
            }
            else {temp.swap_00_01(&matrix)
                temp.swap_00_10(&matrix) }
        case (0, 2):
            if(matrix[1][0] == str[1] || matrix[1][0] == str[2] ||
               matrix[0][0] == str[1] || matrix[0][0] == str[2] ||
               matrix[0][1] == str[1] || matrix[0][1] == str[2]) {
                temp.swap_02_12(&matrix)
                temp.swap_12_22(&matrix)
                temp.swap_21_22(&matrix)
            } else {
                temp.swap_01_02(&matrix)
                temp.swap_00_01(&matrix)
                temp.swap_00_10(&matrix)
            }
        case (1, 2):
            if(matrix[2][1] == str[1] || matrix[2][1] == str[2] ||
               matrix[2][2] == str[1] || matrix[2][2] == str[2] ) {
                temp.swap_02_12(&matrix)
                temp.swap_01_02(&matrix)
                temp.swap_00_01(&matrix)
                temp.swap_00_10(&matrix)
            }
            else {
                temp.swap_12_22(&matrix)
                temp.swap_21_22(&matrix)
            }
        case (2, 2):
            if(matrix[2][1] == str[1] || matrix[2][1] == str[2]) {
                temp.swap_12_22(&matrix)
                temp.swap_02_12(&matrix)
                temp.swap_01_02(&matrix)
                temp.swap_00_01(&matrix)
                temp.swap_00_10(&matrix)
            }
            else {
                temp.swap_21_22(&matrix) }
        default:
            return
        } }
        else if flag == 2 {
            switch (i, j) {
            case (0, 1):
                if matrix[0][0] == str[3] ||  matrix[0][0] == str[4] ||  matrix[0][0] == str[5] {
                    temp.swap_01_02(&matrix)
                    temp.swap_02_12(&matrix)
                    temp.swap_12_22(&matrix)
                }
                else {temp.swap_00_01(&matrix) }
            case (0, 2):
                if matrix[0][0] == str[3] ||  matrix[0][0] == str[4] ||  matrix[0][0] == str[5] ||
                    matrix[0][1] == str[3] ||  matrix[0][1] == str[4] ||  matrix[0][1] == str[5]
                {
                    temp.swap_02_12(&matrix)
                    temp.swap_12_22(&matrix)
                }
                else {
                    temp.swap_01_02(&matrix)
                    temp.swap_00_01(&matrix)
                }
            case (1, 2):
                if matrix[2][2] == str[3] ||  matrix[2][2] == str[4] ||  matrix[2][2] == str[5]{
                    temp.swap_02_12(&matrix)
                    temp.swap_01_02(&matrix)
                    temp.swap_00_01(&matrix)
                }
                else {
                    temp.swap_12_22(&matrix)
                }

            default:
                return
            }

        }
        else if flag == 3{
            switch (i, j) {

            case (0, 0):
                temp.swap_00_01(&matrix)
            case (2, 2):
                temp.swap_12_22(&matrix)

            default:
                return
            }
        }
    else {
        switch (i, j) {
        case (1, 0):
            temp.swap_00_10(&matrix)
            temp.swap_00_01(&matrix)
            temp.swap_01_02(&matrix)
        case (0, 0):
            temp.swap_00_01(&matrix)
            temp.swap_01_02(&matrix)
        case (0, 1):
            temp.swap_01_02(&matrix)
        case (1, 2):
            temp.swap_02_12(&matrix)
        case (2, 2):
            temp.swap_12_22(&matrix)
            temp.swap_02_12(&matrix)
        case (2, 1):
            temp.swap_21_22(&matrix)
            temp.swap_12_22(&matrix)
            temp.swap_02_12(&matrix)

        default:
            return
        }
    }
}

func findMinExcludingCenter(_ matrix: inout Matrix, _ sortedMX: [Int])  {
    var flag: Int = 1
    
    guard matrix.count == 3, matrix.allSatisfy({ $0.count == 3 }) else {
        return
    }
    
    let minMX = sortedMX.min() ?? 0
    
    for i in 0..<3 {
        for j in 0..<3 {
            if i == 1 && j == 1 {
                continue
            }
            if matrix[1][1] != sortedMX[3] && matrix[1][1] != sortedMX[4] && matrix[1][1] != sortedMX[5]{
                while matrix[1][1] != sortedMX[3] && matrix[1][1] != sortedMX[4] && matrix[1][1] != sortedMX[5] {
                    Rot(&matrix, aroundA: 0, 0)
                    mRot(&matrix, aroundA: 0, 1)
                    Rot(&matrix, aroundA: 1, 0)
                    mRot(&matrix, aroundA: 1, 1)
                }
            }
            
            let currentValue = matrix[i][j]
            if currentValue == minMX {
                casilkaLOWEST(&matrix, i, j)
            }
        }
    }

    while flag != 5 {
        switch flag {
        case 1:
            for i in 0..<3 {
                for j in 0..<3 {
                    if i == 1 && j == 1 {
                        continue
                    }
                    let currentValue = matrix[i][j]
                    if currentValue == sortedMX[1] || currentValue == sortedMX[2] {
                        casilkaJOIN(&matrix, i, j, sortedMX, flag)
                    }
                }
            }
        case 2:
            for i in 0..<3 {
                for j in 0..<3 {
                    if i == 1 && j == 1 {
                        continue
                    }
                    let currentValue = matrix[i][j]
                    if currentValue == sortedMX[3] || currentValue == sortedMX[4] || currentValue == sortedMX[5]{
                        casilkaJOIN(&matrix, i, j, sortedMX, flag)
                    }
                }
            }
        case 3:
            for i in 0..<3 {
                for j in 0..<3 {
                    if i == 1 && j == 1 {
                        continue
                    }
                    let currentValue = matrix[i][j]
                    if currentValue == sortedMX[6] || currentValue == sortedMX[7]{
                        casilkaJOIN(&matrix, i, j, sortedMX, flag)
                    }
                }
            }
        case 4:
            for i in 0..<3 {
                for j in 0..<3 {
                    if i == 1 && j == 1 {
                        continue
                    }
                    let currentValue = matrix[i][j]
                    if currentValue == sortedMX[8]{
                        casilkaJOIN(&matrix, i, j, sortedMX, flag)
                    }
                }
            }
        default: return
        }
        flag+=1
    }
}

func sortLargeMatrixBySubmatrices(_ matrix: [[Int]], _ mxCol: Int, _ mxRow: Int) -> [[Int]] {
    guard matrix.count >= 3, matrix[0].count >= 3 else {
        fatalError("Матрица должна быть хотя бы 3×3")
    }
    var resultMatrix = matrix
    let limit = (mxCol-3+1)
    
    for _ in 0...limit {
        for i in 0...(matrix.count - 3) {
            for j in 0...(matrix[i].count - 3) {
                var submatrix = Array(repeating: Array(repeating: 0, count: 3), count: 3)
                
                for k in 0..<3 {
                    for l in 0..<3 {
                        submatrix[k][l] = resultMatrix[i + k][j + l]
                    }
                }
                
                let sortedValues = flattenAndSort(submatrix)
                findMinExcludingCenter(&submatrix, sortedValues)

                for k in 0..<3 {
                    for l in 0..<3 {
                        resultMatrix[i + k][j + l] = submatrix[k][l]
                    }
                }
            }
        }
    }
    
    return resultMatrix
}

// Reset counters before each run
func resetCounters() {
    rotCount = 0
    mRotCount = 0
    swapHCount = 0
    swapVCount = 0
    operationLog = []
}

// Test with the example matrix
resetCounters()
var original: Matrix = [
    [9, 8, 7],
    [6, 5, 4],
    [3, 2, 1]
]

print("Оригинальная матрица 3х3:")
printMatrix(original)
var sortedMX = flattenAndSort(original)

findMinExcludingCenter(&original, sortedMX)
print("Отсортированная матрица 3х3:")
printMatrix(original)

var mxSize = (col: 50, row: 50)

let randMX = generateRandomMatrix(mxSize.col, mxSize.row)
print("\nОригинальная рандомная матрица \(mxSize.col)х\(mxSize.row):")
printMatrix(randMX)

let tempRes = sortLargeMatrixBySubmatrices(randMX,mxSize.col,mxSize.row)
print("\nОтсортированная рандомная матрица \(mxSize.col)х\(mxSize.row):")
printMatrix(tempRes)

print("\nКоличество операций:")
print("Rot: \(rotCount)")
print("mRot: \(mRotCount)")
print("swapH: \(swapHCount)")
print("swapV: \(swapVCount)")
print("Всего: \(rotCount + mRotCount + swapHCount + swapVCount)")

// TIO.RUN не позволяет вывести весь набор команд (объём вывода превышает 128 кб)
//print("\nПроизведенные операции:")
//print(operationLog.joined(separator: " "))
