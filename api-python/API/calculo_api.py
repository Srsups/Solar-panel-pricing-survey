from flask import Flask, request, jsonify
from flask_cors import CORS
import math

app = Flask(__name__)
CORS(app)

VALOR_PAINEL = 3000  # entre 2500 a 3500, vou usar a média de 3000 reais por painel

def calcular_potencia_necessaria(consumo_mensal_kwh, horas_sol_dia):
    return consumo_mensal_kwh / (30 * horas_sol_dia)

def calcular_area_necessaria(qtd_paineis, area_painel_m2=1.6):
    return qtd_paineis * area_painel_m2

@app.route('/calcular', methods=['POST'])
def calcular():
    dados = request.get_json()

    try:
        consumo_mensal_kwh = float(dados.get('consumo_mensal_kwh'))
        horas_sol_dia = float(dados.get('horas_sol_dia'))
        tarifa_energia = float(dados.get('tarifa_energia'))
        preco_medio_conta = float(dados.get('preco_medio_conta'))
        espaco_disponivel_m2 = float(dados.get('espaco_disponivel_m2'))
    except (TypeError, ValueError):
        return jsonify({'erro': 'Valores inválidos ou ausentes.'}), 400

    potencia_necessaria_kwp = calcular_potencia_necessaria(consumo_mensal_kwh*1.15, horas_sol_dia) #é bom utilizar um número de 10% a 15% maior de consumo para garantir que o sistema não fique sobrecarregado
    
    geracao_painel = 75  # kWh/mês (estimativa de valor médio de geração mensal de um painel solar, existem muitas variáveis que influenciam na geração de energia, como a localização geográfica, a inclinação do painel, entre outros fatores)

    quantidade_paineis = math.ceil(consumo_mensal_kwh/geracao_painel)

    area_total = calcular_area_necessaria(quantidade_paineis)

    espaco_suficiente = espaco_disponivel_m2 >= area_total
    area_extra = max(0, area_total - espaco_disponivel_m2)

    custo_total = quantidade_paineis * VALOR_PAINEL #8 painéis * 3000 = 24000 (valores fictícios para exemplo)

    economia_anual = preco_medio_conta * 12 #200 mes * 12 meses = 2400 ano custo sem energia solar
    print(f"Economia Anual: {economia_anual}")
    economia_total = economia_anual - 540 #540 é o valor médio de energia que a pessoa vai continuar pagando mesmo com energia solar (estimativa, algo entre R$30 e R$60), pois o sistema não consegue gerar 100% da energia necessária para a casa, e mesmo se gerasse, existe a tarifa de Consumo mínimo faturável ou Custo de disponibilidade
    payback = custo_total / economia_total if economia_anual else None # não estou levando em conta a inflação, o aumento do preço da energia, etc. O payback é o tempo que leva para o investimento se pagar com a economia gerada pela energia solar. Se o payback for maior que 10 anos, não vale a pena investir em energia solar, pois o sistema pode apresentar problemas e não gerar a energia necessária para a casa. O ideal é que o payback seja menor que 5 anos.
    print(f"Economia Anual: {payback}")

    resultado = {
        'potencia_necessaria_kwp': round(potencia_necessaria_kwp, 2),
        'quantidade_paineis': quantidade_paineis,
        'area_necessaria_m2': round(area_total, 2),
        'espaco_disponivel_m2': round(espaco_disponivel_m2, 2),
        'espaco_suficiente': espaco_suficiente,
        'area_extra_necessaria_m2': round(area_extra, 2),
        'custo_total_r$': round(custo_total, 2),
        'payback_anos': round(payback, 2) if payback else None
    }

    return jsonify(resultado)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
