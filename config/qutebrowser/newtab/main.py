from flask import Flask, render_template, Response
import re

app = Flask(__name__)

def generate_css():
    scss_path = "/home/efe/.config/riftbar/theme.scss"

    var_pattern = re.compile(r"^\s*\$(?P<name>[\w-]+)\s*:\s*(?P<value>.+?);")
    ref_pattern = re.compile(r"\$(?P<name>[\w-]+)")

    variables = {}
    with open(scss_path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.split("//")[0].strip()
            if not line:
                continue
            match = var_pattern.match(line)
            if match:
                variables[match.group("name")] = match.group("value").strip()

    def resolve(value, depth=0):
        if depth > 10:
            raise RuntimeError("Circular SCSS variable reference")
        return ref_pattern.sub(lambda m: resolve(variables[m.group("name")], depth+1)
                               if m.group("name") in variables else m.group(0), value)

    resolved = {k: resolve(v) for k, v in variables.items()}

    css = ":root {\n" + "\n".join(f"  --{k.replace('_','-')}: {v};" for k,v in resolved.items()) + "\n}"
    return css

@app.route('/theme_web.css')
def theme_css():
    css = generate_css()
    return Response(css, mimetype='text/css')

@app.route('/')
def index():
    return render_template("index.html")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

