function separatedImage = separarObjetos2(binaryImage)
    % 1. Aplicar Watershed para separar vacas próximas
    distance = -bwdist(~binaryImage); % Distância transformada negativa
    distance = imhmin(distance, 4); % Supressão de mínimos locais para evitar divisões excessivas
    waterMask = watershed(distance);
    
    % 2. Criar a linha de separação das regiões watershed
    separationLines = (waterMask == 0);
    
    % 3. Engrossar as separações (linhas watershed)
    se = strel('disk', 2); % Elemento estruturante circular com raio 2 (pode ajustar o tamanho)
    thickSeparationLines = imdilate(separationLines, se); % Dilatar as linhas de separação
    
    % 4. Aplicar a máscara das separações dilatadas à imagem binária
    binaryImage(thickSeparationLines) = 0; % Definir as separações como 0 (preto)
    
    % 5. Retornar a imagem separada
    separatedImage = binaryImage;
end
