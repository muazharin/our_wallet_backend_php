<?php

defined('BASEPATH') or exit('No direct script access allowed');


require APPPATH . 'libraries/REST_Controller.php';

class Auth extends REST_Controller
{
	public function __construct() {
		parent::__construct();
		$this->load->model('M_auth');
	}

	public function auth_register_post() {
		try {
			$this->form_validation->set_data($this->post());
			$this->form_validation->set_rules('username', 'Username', 'required|trim|xss_clean');
			$this->form_validation->set_rules('password', 'Password', 'required|trim|xss_clean');
			$this->form_validation->set_rules('email', 'Email', 'required|trim|xss_clean');
			$this->form_validation->set_rules('phone', 'Phone', 'required|trim|xss_clean');
			if (!$this->form_validation->run()) {
				$message = [
					'status' => false,
					'message' => 'Lengkapi semua field! dengan benar',
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}else{
				$result = $this->M_auth->register();
				if($result['status']){
					$message = [
						'status' => true,
						'message' => $result['message'],
						'data' => $result['data'],
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
			$message = [
				'status' => false,
				'message' => $th->getMessage(),
			];
			$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
		}
	}

	public function auth_login_post() {
		try {
			$this->form_validation->set_data($this->post());
			$this->form_validation->set_rules('username', 'Username', 'required|trim|xss_clean');
			$this->form_validation->set_rules('password', 'Password', 'required|trim|xss_clean');
			if(!$this->form_validation->run()){
				$message = [
					'status' => false,
					'message' => 'Lengkapi semua field! dengan benar',
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}else{
				$result = $this->M_auth->login();
				if($result['status']){
					$message = [
						'status' => true,
						'message'=> $result['message'],
						'data' => $result['data'],
					];
					$this->set_response($message, REST_Controller::HTTP_OK);
				}else{
					$message = [
						'status' => false,
						'msessage' => $result['message'],
					];
					$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
				}
			}
		} catch (\Throwable $th) {
			$message = [
				'status' => false,
				'message' => $th->getMessage(),
			];
			$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
		}
	}
}