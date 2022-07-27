import sys
import webbrowser
sys.path.append("libs")
url = 'http://10.236.253.13:8006/knead/order?20220721154509'
webbrowser.open(url)
print(webbrowser.get())