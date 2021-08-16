FROM python:3.8

WORKDIR /app
COPY requirements.txt requirements.txt

RUN pip3 install numpy
# TA-Lib
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
  tar -xvzf ta-lib-0.4.0-src.tar.gz && \
  cd ta-lib/ && \
  ./configure --prefix=/usr && \
  make && \
  make install

RUN rm -R ta-lib ta-lib-0.4.0-src.tar.gz
 
RUN pip3 install -r requirements.txt
RUN pip3 install twelvedata[pandas,matplotlib,plotly]
RUN pip3 install websocket
COPY . .

RUN chmod u+x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
