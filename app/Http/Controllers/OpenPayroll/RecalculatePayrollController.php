<?php

namespace App\Http\Controllers\OpenPayroll;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class RecalculatePayrollController extends Controller
{
    public function __invoke(Request $request, $id)
    {
        payroll($id)->calculate();

        flash('You have successfully recalculate all paylips.')->success();

        return redirect()->route('open-payroll.payroll.show', $id);
    }
}
