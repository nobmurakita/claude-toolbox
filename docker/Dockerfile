FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_BREAK_SYSTEM_PACKAGES=1
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

RUN apt-get update && apt-get install -y --no-install-recommends \
    # Python
    python3 python3-pip \
    # 基本ツール
    curl wget jq git \
    # PDF
    poppler-utils ghostscript qpdf \
    # 画像・動画
    ffmpeg imagemagick \
    # フォント
    fonts-noto-cjk \
    # その他
    zip unzip file \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    # データ処理・計算
    pandas numpy scipy \
    # スプレッドシート・ドキュメント
    openpyxl xlsxwriter lxml python-pptx pdfplumber \
    # 画像・可視化
    pillow matplotlib seaborn plotly kaleido \
    # Web・スクレイピング
    requests beautifulsoup4 \
    # テキスト・テンプレート
    jinja2 pyyaml tabulate chardet

WORKDIR /work/pwd
