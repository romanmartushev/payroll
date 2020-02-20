<?php

namespace App\Http\Controllers\OpenPayroll;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class RecalculatePayslipController extends Controller
{
    public function __invoke(Request $request, $id)
    {
        payslip($id)->calculate();

        flash('You have successfully recalculate a payslip.')->success();

        return redirect()->route('open-payroll.payslip.show', $id);
    }
}
