function binaryImage = binarizeImage(smoothImage, level)
    % Função para binarizar a imagem usando limiarização
    % smoothImage: Imagem suavizada
    % level: (Opcional) Limiar para binarização. Se não fornecido, o limiar é calculado automaticamente.
    % binaryImage: Imagem binária

    if nargin < 2
        % Se o nível não for fornecido, calcular o limiar automaticamente usando Otsu
        level = graythresh(smoothImage);
    end
    
    % Aplicar binarização com o nível fornecido
    binaryImage = imbinarize(smoothImage, level);
end
