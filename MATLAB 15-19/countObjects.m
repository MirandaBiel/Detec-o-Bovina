function numObjects = countObjects(refinedImage)
    % Função para contar os objetos na imagem
    % refinedImage: Imagem após transformações morfológicas
    % numObjects: Número de objetos detectados

    % Etiquetar objetos conectados
    [~, numObjects] = bwlabel(refinedImage);
end
