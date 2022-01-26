<?php

defined('BASEPATH') or exit('No direct script access allowed');


require APPPATH . 'libraries/REST_Controller.php';

class Wallet extends REST_Controller
{
	public function __construct() {
		parent::__construct();
		$this->load->model('M_wallet');
	}
	public function get_wallet_get(){
		try {
			$result = $this->M_wallet->get_wallet();
			if($result['status']){
				$message = [
					'status'=> true,
					'message'=> $result['message'],
					'data'=> $result['data'],
				];
				$this->set_response($message, REST_Controller::HTTP_OK);
			}else{
				$message=[
					'status'=>false,
					'message'=> $result['message'],
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}
		} catch (\Throwable $th) {
			$message = [
				'status' => false,
				'message' => $th->getMessage(),
			];
			$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
		}
		
	}
	public function create_wallet_post(){
		try {
			$this->form_validation->set_data($this->post());
			$this->form_validation->set_rules('userId', 'User Id', 'required|trim|xss_clean');
			$this->form_validation->set_rules('walletName', 'Wallet Name', 'required|trim|xss_clean');
			$this->form_validation->set_rules('walletColor', 'Wallet Color', 'required|trim|xss_clean');
			if (!$this->form_validation->run()) {
				$message = [
					'status' => false,
					'message' => 'Lengkapi semua field dengan benar!',
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}else{
				$result = $this->M_wallet->create_wallet();
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
	public function update_wallet_post(){
		try {
			$this->form_validation->set_data($this->post());
			$this->form_validation->set_rules('userId', 'User Id', 'required|trim|xss_clean');
			$this->form_validation->set_rules('walletName', 'Wallet Name', 'required|trim|xss_clean');
			$this->form_validation->set_rules('walletColor', 'Wallet Color', 'required|trim|xss_clean');
			if (!$this->form_validation->run()) {
				$message = [
					'status' => false,
					'message' => 'Lengkapi semua field dengan benar!',
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}else{
				$result = $this->M_wallet->update_wallet();
				if($result['status']){
					$message = [
						'status' => true,
						'message' => $result['message'],
					];
					$this->set_response($message, REST_Controller::HTTP_OK);
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
				'status' => false,
				'message' => $th->getMessage(),
			];
			$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
		}
	}
	public function add_member_wallet_post(){
		try {
			$this->form_validation->set_data($this->post());
			$this->form_validation->set_rules('userId', 'User Id', 'required|trim|xss_clean');
			$this->form_validation->set_rules('memberId', 'Member Id', 'required|trim|xss_clean');
			if (!$this->form_validation->run()) {
				$message = [
					'status' => false,
					'message' => 'Lengkapi semua field dengan benar!',
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}else{
				$result = $this->M_wallet->add_member_wallet();
				if($result['status']){
					$message = [
						'status' => true,
						'message' => $result['message'],
					];
					$this->set_response($message, REST_Controller::HTTP_OK);
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
				'status' => false,
				'message' => $th->getMessage(),
			];
			$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
		}
	}
	public function get_user_to_wallet_get(){
		try {
			$result = $this->M_wallet->get_user_to_wallet();
			if($result['status']){
				$message = [
					'status'=> true,
					'message'=> $result['message'],
					'data'=> $result['data'],
				];
				$this->set_response($message, REST_Controller::HTTP_OK);
			}else{
				$message=[
					'status'=>false,
					'message'=> $result['message'],
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}
		} catch (\Throwable $th) {
			$message = [
				'status' => false,
				'message' => $th->getMessage(),
			];
			$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
		}
	}
	public function get_member_of_wallet_get($id = null){
		try {
			$result = $this->M_wallet->get_member_of_wallet($id);
			if($result['status']){
				$message = [
					'status'=> true,
					'message'=> $result['message'],
					'data'=> $result['data'],
				];
				$this->set_response($message, REST_Controller::HTTP_OK);
			}else{
				$message=[
					'status'=>false,
					'message'=> $result['message'],
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}
		} catch (\Throwable $th) {
			$message = [
				'status' => false,
				'message' => $th->getMessage(),
			];
			$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
		}
	}
	public function confirm_member_wallet_post(){
		try {
			$this->form_validation->set_data($this->post());
			$this->form_validation->set_rules('confirm', 'Confirm', 'required|trim|xss_clean');
			if (!$this->form_validation->run()) {
				$message = [
					'status' => false,
					'message' => 'Lengkapi semua field dengan benar!',
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
			}else{
				$result = $this->M_wallet->confirm_member_wallet();
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
	public function invited_check_wallet_get(){
		try {
			$result = $this->M_wallet->invited_check_wallet();
			if($result['status']){
				$message = [
					'status'=> true,
					'message'=> $result['message'],
					'data'=> $result['data'],
				];
				$this->set_response($message, REST_Controller::HTTP_OK);
			}else{
				$message=[
					'status'=>false,
					'message'=> $result['message'],
				];
				$this->set_response($message, REST_Controller::HTTP_BAD_REQUEST);
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
