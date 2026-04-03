FROM python:3.14-slim
RUN pip install --no-cache-dir \
    # データ処理・計算
    pandas numpy scipy \
    # スプレッドシート・ドキュメント
    openpyxl xlsxwriter lxml python-pptx pdfplumber \
    # 画像・可視化
    pillow matplotlib seaborn \
    # Web・スクレイピング
    requests beautifulsoup4 \
    # テキスト・テンプレート
    jinja2 pyyaml tabulate chardet
WORKDIR /workspace
