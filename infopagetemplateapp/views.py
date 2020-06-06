from django.shortcuts import render
from .models import Banner

# Create your views here.
def index(request):
    banPlh1 = Banner.objects.filter(ban_placeholder='pl1').order_by('ban_placeholder')
    banPlh2 = Banner.objects.filter(ban_placeholder='pl2').order_by('ban_placeholder')
    indxDct = {'banPlhNb1':banPlh1}
    indxDct['banPlhNb2'] = banPlh2

    return render(request, 'index.html', context=indxDct)