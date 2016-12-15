import numpy as np
import sys
import timeit

start = timeit.default_timer()
data = np.loadtxt(sys.argv[1], delimiter=",")

w = np.array([0.0 for i in range(28)])

def grad_func(row):
    global w
    label = row[0]
    features = row[1:]
    mult = (1/(1+np.exp(label*(np.dot(w, features))))-1)*-label
    features *= mult
    return features

for i in range(10):
    grad = np.apply_along_axis(grad_func, 1, data)
    reduced = np.sum(grad)
    end = timeit.default_timer()
    print w
    print (end - start)/1000
    start = end
