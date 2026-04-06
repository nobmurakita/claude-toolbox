FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

# キャッシュディレクトリの書き込み権限を付与
RUN chmod -R 777 /var/cache

RUN apt-get update && apt-get install -y --no-install-recommends \
    # 基本ツール
    ca-certificates curl wget jq git gnupg zip unzip file tree \
    # PDF
    poppler-utils ghostscript qpdf \
    # 画像・動画
    ffmpeg imagemagick librsvg2-bin \
    # ドキュメント変換
    pandoc \
    # グラフ描画
    graphviz \
    # データベース
    sqlite3 \
    # フォント
    fonts-noto-cjk \
    # Python
    python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Node.js 24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    # データ処理・計算
    pandas numpy scipy \
    # スプレッドシート・ドキュメント
    openpyxl xlsxwriter lxml python-pptx \
    # PDF
    pdfplumber pikepdf pymupdf reportlab weasyprint \
    # 画像・可視化
    pillow matplotlib seaborn plotly kaleido \
    # Web・スクレイピング
    requests beautifulsoup4 \
    # 機械学習
    scikit-learn \
    # グラフ解析
    networkx \
    # テキスト・テンプレート
    jinja2 pyyaml tabulate chardet markdown rich

WORKDIR /work/pwd
