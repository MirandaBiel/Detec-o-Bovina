function refinedImage = morphOperations(binaryImage)
    % Função para aplicar operações morfológicas para refinar a imagem
    % binaryImage: Imagem binária
    % refinedImage: Imagem após operações morfológicas

    se = strel('disk', 4); % Elemento estruturante circular com raio 3 (ajuste conforme necessário)
    morphedImg = imopen(binaryImage, se); % Abertura morfológica para remover pequenos objetos
    morphedImg = imclose(morphedImg, se); % Fechamento morfológico para preencher buracos
    im = imfill(morphedImg, 'holes'); % Preencher buracos nos objetos detectados
    imshow(im);
    
    refinedImage = im;
end
