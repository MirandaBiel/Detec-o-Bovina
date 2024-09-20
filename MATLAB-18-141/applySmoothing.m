function smoothImage = applySmoothing(grayImage, kernelSize, sigma)
    % Função para suavizar a imagem e remover ruídos
    % grayImage: Imagem em escala de cinza
    % kernelSize: Tamanho do kernel (ex.: [5 5])
    % sigma: Desvio padrão do filtro Gaussiano
    % smoothImage: Imagem suavizada

    % Criar a máscara de filtro Gaussiano com o tamanho e sigma fornecidos
    h = fspecial('gaussian', kernelSize, sigma);
    
    % Aplicar o filtro Gaussiano à imagem
    smoothImage = imfilter(grayImage, h);
    figure;
    imshow(smoothImage, []);

end
