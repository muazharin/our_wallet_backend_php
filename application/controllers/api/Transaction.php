<?php

defined('BASEPATH') or exit('No direct script access allowed');


require APPPATH . 'libraries/REST_Controller.php';

class Transaction extends REST_Controller
{
	public function __construct() {
		parent::__construct();
		$this->load->model('M_transaction');
	}

	public function transaction_post($id){
		try {
			$this->form_validation->set_data($this->post());
			$this->form_validation->set_rules('transaction_user_id', 'User Id', 'required|trim|xss_clean');
			$this->form_validation->set_rules('transaction_type', 'Type', 'required|trim|xss_clean');
			$this->form_validation->set_rules('transaction_title', 'Title', 'required|trim|xss_clean');
			$this->form_validation->set_rules('transaction_detail', 'Detail', 'required|trim|xss_clean');
			$this->form_validation->set_rules('transaction_price', 'Price', 'required|trim|xss_clean');
			if (!$this->form_validation->run()) {
				$message = [
					'status' => false,
					'message' => 'Lengkapi semua field dengan benar!',
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}else{
				$result = $this->M_transaction->transaction($id);
				if($result['status']){
					$message = [
						'status' => true,
						'message' => $result['message'],
					];
					$this->set_response($message, REST_Controller::HTTP_CREATED);
				}else{
					$message = [
						'status' => false,
						'message' => $result['message'],
					];
					$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
				}
				
			}
		} catch (\Throwable $th) {
			$message=[
				'status'=>false,
				'message' => $th->getMessage(),
			];
			$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
		}
	}
}
