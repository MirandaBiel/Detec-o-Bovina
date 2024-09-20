function highPassFilteredImage = filtroPassaAlta(inputImage, cutoffFrequency)
    % Função para aplicar um filtro passa-alta com frequência de corte ajustável
    % inputImage: Imagem de entrada (em escala de cinza)
    % cutoffFrequency: Frequência de corte para o filtro (ajustável)
    % highPassFilteredImage: Imagem filtrada no domínio espacial
    
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

    % Exibir a imagem filtrada
    figure;
    imshow(highPassFilteredImage, []);
    title('Imagem Filtrada com Filtro Passa-Alta');
end
