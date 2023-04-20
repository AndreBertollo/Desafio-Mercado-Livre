import requests
import json

# declarar os parametros
devices = ['Google Home', 'Apple TV', 'Amazon Fire TV','chromecast']
result=[]
array_json=[]

#definir funcao que realiza a busca por produto na api
def get_device_result(devices):
    for device in devices:
        # URL da página com os resultados da pesquisa
        url = "https://api.mercadolibre.com/sites/MLB/search?q=" + device + "&limit=50#json"

        # Fazer uma solicitação GET para obter os resultados da pesquisa
        response = requests.get(url)

        # Analisar o JSON retornado
        json_data = json.loads(response.text)

        # Obter uma lista de identificadores de itens
        items_ids = [item['id'] for item in json_data['results']]
        json_data = {"device": device,
                     "itens": get_itens_details(items_ids)}
        array_json.append(json_data)

#definir a funcao que busca os itens do produto pesquisado
def get_itens_details(items_ids):
    # Loop que passa por cada identificador de item e executa um GET para cada um
    for item_id in items_ids:
        item_url = f"https://api.mercadolibre.com/items/{item_id}"
        item_response = requests.get(item_url)
        item_json = json.loads(item_response.text)
        
        # Armazenar as informações no result
        result.append(item_json)
    return result

# executar a funcao que realiza a chamada de api para cada device, armazenando em um array, que sera convertido para json
get_device_result(devices)
json_array = json.dumps(array_json)