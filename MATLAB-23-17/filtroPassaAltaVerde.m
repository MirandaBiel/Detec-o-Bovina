function greenHighPassFilteredImage = filtroPassaAltaVerde(inputImage, cutoffFrequency)
    % Função para aplicar um filtro passa-alta com frequência de corte ajustável
    % inputImage: Imagem de entrada (em escala de cinza)
    % cutoffFrequency: Frequência de corte para o filtro (ajustável)
    % greenHighPassFilteredImage: Imagem RGB com o filtro aplicado no canal verde
    
    % Passo 1: Obter as dimensões da imagem
    [rows, cols] = size(inputImage);

    % Passo 2: Aplicar a Transformada de Fourier
    fftImage = fftshift(fft2(double(inputImage)));

    % Passo 3: Criar uma grade de frequências normalizadas
    u = (-floor(rows/2):ceil(rows/2)-1) / rows;
    v = (-floor(cols/2):ceil(cols/2)-1) / cols;
    [V, U] = meshgrid(v, u);
    
    % Distância ao centro no domínio da frequência
    D = sqrt(U.^2 + V.^2);

    % Passo 4: Criar o filtro passa-alta com frequência de corte ajustável
    H = double(D >= cutoffFrequency);

    % Passo 5: Aplicar o filtro à imagem no domínio da frequência
    filteredFFT = fftImage .* H;

    % Passo 6: Aplicar a transformada inversa para voltar ao domínio espacial
    inverseFFT = ifft2(ifftshift(filteredFFT));

    % Pegar apenas a parte real da imagem filtrada
    highPassFilteredImage = real(inverseFFT);

    % Passo 7: Normalizar a imagem filtrada para o intervalo [0, 1]
    highPassFilteredImage = mat2gray(highPassFilteredImage);

    % Passo 8: Criar uma imagem RGB com os pixels verdes
    greenHighPassFilteredImage = zeros(rows, cols, 3);  % Inicializa uma imagem RGB com 3 canais (R, G, B)
    
    % O filtro passa-alta será aplicado ao canal verde
    greenHighPassFilteredImage(:,:,2) = highPassFilteredImage;  % Canal verde

    % Passo 9: Exibir a imagem filtrada em RGB com pixels verdes
    figure;
    imshow(greenHighPassFilteredImage);
    title('Imagem Filtrada com Filtro Passa-Alta em Verde');
end
