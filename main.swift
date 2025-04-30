import Foundation

typealias Matrix = [[Int]]

// Функция для поворота подматрицы 2x2 по часовой стрелке (Rot)
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
}

func flattenAndSort(_ matrix: Matrix) -> [Int] {
    // Преобразуем двумерный массив в одномерный
    let flattenedArray = matrix.flatMap { $0 }
    
    // Сортируем массив
    let sortedArray = flattenedArray.sorted()
    
    return sortedArray
}

// Функция для поворота подматрицы 2x2 против часовой стрелки (3*Rot)
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
}

// Функция для горизонтального обмена элементов подматрицы 2x2 (swapH)
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
}

// Функция для вертикального обмена элементов подматрицы 2x2 (swapV)
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
}

// Функция для диагонального преобразования (diagL)
func diagL(_ matrix: inout Matrix, aroundA row: Int, _ col: Int) {
    guard matrix.count > row + 1 && matrix[0].count > col + 1 else { return }
    mRot(&matrix, aroundA: row, col)
    swapH(&matrix, aroundA: row, col)
}

// Функция для диагонального преобразования (diagB)
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
    /*
     # Z Z
     # # #
     # # #
     */
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
    var temp = Frame()
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
    var temp = Frame()
    if flag == 1 {
        switch (i, j) {
        case (0, 0):
            temp.swap_00_10(&matrix)
        case (0, 1):
            temp.swap_00_01(&matrix)
            temp.swap_00_10(&matrix)
        case (0, 2):
            temp.swap_01_02(&matrix)
            temp.swap_00_01(&matrix)
            temp.swap_00_10(&matrix)
        case (1, 2):
            temp.swap_02_12(&matrix)
            temp.swap_01_02(&matrix)
            temp.swap_00_01(&matrix)
            temp.swap_00_10(&matrix)
        case (2, 2):
            temp.swap_21_22(&matrix)
        default:
            return
        } }
        else if flag == 2 {
            switch (i, j) {
            case (1, 0):
                temp.swap_00_10(&matrix)
            case (0, 1):
                temp.swap_00_01(&matrix)
            case (0, 2):
                temp.swap_01_02(&matrix)
                temp.swap_00_01(&matrix)
            case (1, 2):
                temp.swap_12_22(&matrix)
            case (2, 1):
                temp.swap_21_22(&matrix)
            default:
                return
            }

        }
        else if flag == 3{
            switch (i, j) {
            case (1, 0):
                temp.swap_00_10(&matrix)
                temp.swap_00_01(&matrix)
            case (0, 0):
                temp.swap_00_01(&matrix)
            case (2, 2):
                temp.swap_12_22(&matrix)
            case (2, 1):
                temp.swap_21_22(&matrix)
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
    // Проверяем, что матрица 3x3
    guard matrix.count == 3, matrix.allSatisfy({ $0.count == 3 }) else {
        return
    }
    
    var minMX = sortedMX.min() ?? 0
    

    
    for i in 0..<3 {
        for j in 0..<3 {
            // Пропускаем центральную ячейку (1,1)
            if i == 1 && j == 1 {
                continue
            }
            if matrix[1][1] == minMX && (matrix[0][0] == sortedMX[3] || matrix[0][0] == sortedMX[4] || matrix[0][0] == sortedMX[5]) {
                diagB(&matrix, aroundA: 0, 0)
            }
            if matrix[1][1] == minMX && (matrix[0][2] == sortedMX[3] || matrix[0][2] == sortedMX[4] || matrix[0][2] == sortedMX[5]) {
                diagL(&matrix, aroundA: 0, 1)
            }
            if matrix[1][1] == minMX && (matrix[2][2] == sortedMX[3] || matrix[2][2] == sortedMX[4] || matrix[2][2] == sortedMX[5]) {
                diagB(&matrix, aroundA: 1, 1)
            }
            if matrix[1][1] == minMX && (matrix[2][0] == sortedMX[3] || matrix[2][0] == sortedMX[4] || matrix[2][0] == sortedMX[5]) {
                diagL(&matrix, aroundA: 1, 0)
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
                    // Пропускаем центральную ячейку (1,1)
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
                    // Пропускаем центральную ячейку (1,1)
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
                    // Пропускаем центральную ячейку (1,1)
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
                    // Пропускаем центральную ячейку (1,1)
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

// Пример использования
//var original: Matrix = [
//    [7, 26, 3],
//    [15, 9, 10],
//    [22, 16, 4]
//]

var original: Matrix = [
    [34, 234, 7],
    [4, 1, 2],
    [99, 9, 86]
]


print("Original matrix:")
printMatrix(original)




var sortedMX = flattenAndSort(original)
print(sortedMX)

var minMX = sortedMX.min() ?? 0
print(minMX)

findMinExcludingCenter(&original, sortedMX)
printMatrix(original)

