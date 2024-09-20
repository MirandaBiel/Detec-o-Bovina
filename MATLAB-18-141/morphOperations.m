function refinedImage = morphOperations(binaryImage)
    % Função para aplicar operações morfológicas para refinar a imagem
    % binaryImage: Imagem binária
    % refinedImage: Imagem após operações morfológicas

    %se = strel('disk', 1); % Elemento estruturante circular com raio 3 (ajuste conforme necessário)
    %morphedImg = imdilate(binaryImage, se); % Abertura morfológica para remover pequenos objetos
    %im = morphedImg;
    %se = strel('disk', 3);
    %im = imclose(im, se);
    %im = imfill(im, 'holes'); % Preencher buracos nos objetos detectados
    
    refinedImage = imfill(binaryImage, 'holes');
end
