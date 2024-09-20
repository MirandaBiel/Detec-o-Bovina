function resultImage = aplicarMascara(binImage, grayImage)
    % Função para aplicar uma máscara de uma imagem binarizada sobre uma imagem em escala de cinza
    % binImage: Imagem binarizada (com valores 0 ou 1)
    % grayImage: Imagem original em escala de cinza
    % resultImage: Imagem resultante com fundo preto e partes da imagem cinza

    % Certifique-se de que a imagem binarizada é lógica (0 ou 1)
    binImage = logical(binImage);
    
    % Inicializa a imagem de saída como uma imagem preta (mesmas dimensões da imagem cinza)
    resultImage = zeros(size(grayImage), 'uint8');
    
    % Onde a imagem binarizada for branca (1), colocar o valor da imagem em escala de cinza
    resultImage(binImage) = grayImage(binImage);
    
    % Onde a imagem binarizada for preta (0), a imagem resultante já é 0 (preto)
end
