def call(int a, int b) {
    def sum = a + b
    echo "Number 1 = ${a}"
    echo "Number 2 = ${b}"
    echo "The sum is: ${sum}"
    return sum
}
