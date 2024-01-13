<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use OpenTelemetry\API\Trace\Span;
use OpenTelemetry\API\Trace\StatusCode;
use OpenTelemetry\SDK\Trace\TracerProvider;

class HelloController extends Controller
{
    public function index(){
        echo 'teste';
    }
}
