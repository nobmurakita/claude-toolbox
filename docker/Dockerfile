FROM python:3.14-slim
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
RUN apt-get update && apt-get install -y --no-install-recommends \
    fonts-noto-cjk \
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
RUN useradd -m sandbox && chown -R sandbox /usr/local/lib/python3.14/site-packages
USER sandbox
WORKDIR /work/pwd
