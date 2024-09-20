function filteredImage = gaussianLowPassFilterRGB(image, kernelSize, sigma)
    % Verificar se a imagem está em RGB
    if size(image, 3) ~= 3
        error('A imagem deve ser RGB.');
    end
    
    % Inicializar a imagem filtrada
    filteredImage = zeros(size(image), 'like', image);
    
    % Aplicar o filtro gaussiano em cada canal de cor (R, G, B)
    for i = 1:3
        filteredImage(:, :, i) = imgaussfilt(image(:, :, i), sigma, 'FilterSize', kernelSize);
    end
end
