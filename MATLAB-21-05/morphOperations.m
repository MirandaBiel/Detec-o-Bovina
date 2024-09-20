function refinedImage = morphOperations(binaryImage)
    % Função para aplicar operações morfológicas para refinar a imagem
    % binaryImage: Imagem binária
    % refinedImage: Imagem após operações morfológicas

    se = strel('disk', 5); % Elemento estruturante circular com raio 3 (ajuste conforme necessário)
    morphedImg = imopen(binaryImage, se); % Abertura morfológica para remover pequenos objetos
    im = morphedImg;
    se = strel('disk', 2);
    im = imclose(im, se); % Fechamento morfológico para preencher buracos
    im = imfill(im, 'holes'); % Preencher buracos nos objetos detectados
    im = imerode(im, se);
    se = strel('disk', 5);
    im = imopen(im, se);
    
    refinedImage = im;
end
