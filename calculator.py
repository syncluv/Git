from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/calculate', methods=['POST'])
def calculate():
    operator = request.form['operator']
    if operator == 'sqrt':
        num2 = 0
    else:
        num2 = float(request.form['num2'])
    num1 = float(request.form['num1'])
    result = 0
    algebra_type = str
    
    if operator == 'add':
        result = num1 + num2
        algebra_type = "Addition"
    elif operator == 'subtract':
        result = num1 - num2
        algebra_type = "Subtraction"
    elif operator == 'multiply':
        result = num1 * num2
        algebra_type = "Multiplication"
    elif operator == 'divide':
        result = num1 / num2
        algebra_type = "Division"
    elif operator == 'sqrt':
        result = num1 ** 0.5
        algebra_type = "Square Root"
    return render_template('result.html', result=result, algebra_type=algebra_type)

if __name__ == '__main__':
    app.run(host='0.0.0.0',debug=True)
