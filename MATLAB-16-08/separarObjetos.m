function separatedImage = separarObjetos(binaryImage)
    % 6. Aplicar Watershed para separar vacas próximas
    distance = -bwdist(~binaryImage); % Distância transformada negativa
    distance = imhmin(distance, 4); % (4) Supressão de mínimos locais para evitar divisões excessivas
    waterMask = watershed(distance);
    binaryImage(waterMask == 0) = 0; % Aplicação da máscara watershed para separar objetos
    separatedImage = binaryImage;
end
