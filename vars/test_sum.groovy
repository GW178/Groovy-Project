def call() {
    def num1 = (int)(Math.random() * 100)
    def num2 = (int)(Math.random() * 100)
    
    echo "Generated numbers: ${num1}, ${num2}"
    
    def expectedSum = num1 + num2
    def actualSum = sum(num1, num2)
    
    if (expectedSum == actualSum) {
        echo "Test passed: The sum is correct."
    } else {
        error "Test failed: Expected sum ${expectedSum} but got ${actualSum}."
    }
}
