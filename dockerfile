FROM python:3.9.0b1-buster
ENV PYTHONUNBUFFERED 1
RUN mkdir /fake_wix_dir
WORKDIR /fake_wix_dir
COPY requirements.txt /fake_wix_dir/
RUN pip install -r requirements.txt
RUN export DJANGO_SETTINGS_MODULE=mysite.settings
COPY . /fake_wix_dir/